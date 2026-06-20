--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 八雷天神  (ID: 90583279)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Wyrm
-- Level 8
-- ATK 2000 | DEF 2000
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：这张卡可以把自己墓地1只等级或者阶级是8的怪兽除外，从手卡特殊召唤。
-- ②：以自己墓地1只等级或者阶级是8的仪式·融合·同调·超量怪兽为对象才能发动。那只怪兽回到卡组。那之后，回去的怪兽种类的以下效果适用。
-- ●仪式·融合：自己从卡组抽1张。
-- ●同调·超量：这张卡的攻击力上升1000。
--[[ __CARD_HEADER_END__ ]]

--八雷天神
function c90583279.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c90583279.spcon)
	e1:SetTarget(c90583279.sptg)
	e1:SetOperation(c90583279.spop)
	c:RegisterEffect(e1)
	--to deck
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_LEAVE_GRAVE+CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,90583279)
	e2:SetTarget(c90583279.tdtg)
	e2:SetOperation(c90583279.tdop)
	c:RegisterEffect(e2)
end
function c90583279.spfilter(c)
	return (c:IsLevel(8) or c:IsRank(8)) and c:IsAbleToRemoveAsCost()
end
function c90583279.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c90583279.spfilter,tp,LOCATION_GRAVE,0,1,nil)
end
function c90583279.sptg(e,tp,eg,ep,ev,re,r,rp,chk,c)
	local g=Duel.GetMatchingGroup(c90583279.spfilter,tp,LOCATION_GRAVE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local tc=g:SelectUnselect(nil,tp,false,true,1,1)
	if tc then
		e:SetLabelObject(tc)
		return true
	else return false end
end
function c90583279.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=e:GetLabelObject()
	Duel.Remove(g,POS_FACEUP,REASON_SPSUMMON)
end
function c90583279.tdfilter(c,tp)
	return c:IsAbleToDeck()
		and ((c:IsType(TYPE_RITUAL+TYPE_FUSION+TYPE_SYNCHRO) and c:IsLevel(8))
			or (c:IsType(TYPE_XYZ) and c:IsRank(8)))
		and (Duel.IsPlayerCanDraw(tp,1) or c:IsType(TYPE_SYNCHRO+TYPE_XYZ))
end
function c90583279.tdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c90583279.tdfilter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c90583279.tdfilter,tp,LOCATION_GRAVE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c90583279.tdfilter,tp,LOCATION_GRAVE,0,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
	if g:GetFirst():IsType(TYPE_RITUAL+TYPE_FUSION) then
		Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
	end
end
function c90583279.tdop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SendtoDeck(tc,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)>0
		and ((tc:IsType(TYPE_RITUAL) and tc:IsLocation(LOCATION_DECK))
			or (tc:IsType(TYPE_FUSION+TYPE_SYNCHRO+TYPE_XYZ) and tc:IsLocation(LOCATION_EXTRA))) then
		if tc:IsType(TYPE_RITUAL+TYPE_FUSION) then
			Duel.BreakEffect()
			Duel.ShuffleDeck(tp)
			Duel.Draw(tp,1,REASON_EFFECT)
		end
		if tc:IsType(TYPE_SYNCHRO+TYPE_XYZ)
			and c:IsFaceup() and c:IsRelateToEffect(e) then
			Duel.BreakEffect()
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(1000)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
			c:RegisterEffect(e1)
		end
	end
end
