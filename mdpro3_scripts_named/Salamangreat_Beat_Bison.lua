--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 转生炎兽 暴晒野牛  (ID: 25166510)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Cyberse
-- Level 8
-- ATK 2800 | DEF 1000
-- Setcode: 281
--
-- Effect Text:
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：自己墓地有「转生炎兽」怪兽3只以上存在的场合才能发动。这张卡从手卡守备表示特殊召唤。
-- ②：以最多有对方场上的表侧表示的卡数量的自己墓地的炎属性连接怪兽为对象才能发动。那些怪兽回到额外卡组。那之后，可以选最多有回去的卡数量的对方场上的表侧表示的卡，直到回合结束时那个效果无效。
--[[ __CARD_HEADER_END__ ]]

--転生炎獣Bバイソン
function c25166510.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(25166510,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,25166510)
	e1:SetCondition(c25166510.spcon)
	e1:SetTarget(c25166510.sptg)
	e1:SetOperation(c25166510.spop)
	c:RegisterEffect(e1)
	--return
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(25166510,1))
	e2:SetCategory(CATEGORY_TOEXTRA+CATEGORY_DISABLE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,25166511)
	e2:SetTarget(c25166510.target)
	e2:SetOperation(c25166510.operation)
	c:RegisterEffect(e2)
end
function c25166510.cfilter(c)
	return c:IsSetCard(0x119) and c:IsType(TYPE_MONSTER)
end
function c25166510.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c25166510.cfilter,tp,LOCATION_GRAVE,0,3,nil)
end
function c25166510.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c25166510.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
function c25166510.tdfilter(c)
	return c:IsAttribute(ATTRIBUTE_FIRE) and c:IsType(TYPE_LINK) and c:IsAbleToExtra()
end
function c25166510.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c25166510.tdfilter(chkc) end
	local ct=Duel.GetMatchingGroupCount(Card.IsFaceup,tp,0,LOCATION_ONFIELD,nil)
	if chk==0 then return ct>0 and Duel.IsExistingTarget(c25166510.tdfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c25166510.tdfilter,tp,LOCATION_GRAVE,0,1,ct,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,#g,0,0)
end
function c25166510.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	local ct=Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	local tg=Duel.GetMatchingGroup(aux.NegateAnyFilter,tp,0,LOCATION_ONFIELD,nil)
	if ct>0 and #tg>0 and Duel.SelectYesNo(tp,aux.Stringid(25166510,2)) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISABLE)
		local sg=tg:Select(tp,1,ct,nil)
		Duel.HintSelection(sg)
		local tc=sg:GetFirst()
		while tc do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_DISABLE)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e1)
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_DISABLE_EFFECT)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e2)
			tc=sg:GetNext()
		end
	end
end
