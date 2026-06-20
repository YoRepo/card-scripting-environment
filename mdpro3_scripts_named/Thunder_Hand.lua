--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 雷电手  (ID: 16223761)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Thunder
-- Level 4
-- ATK 1600 | DEF 1600
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：这张卡在手卡·墓地存在，原本攻击力或者原本守备力是1600的自己场上的表侧表示怪兽被战斗或者对方的效果破坏送去墓地的场合才能发动。这张卡特殊召唤，选对方场上1张卡破坏。这个效果特殊召唤的这张卡从场
-- 上离开的场合除外。
--[[ __CARD_HEADER_END__ ]]

--サンダー・ハンド
function c16223761.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(16223761,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetCountLimit(1,16223761)
	e1:SetCondition(c16223761.spcon)
	e1:SetTarget(c16223761.sptg)
	e1:SetOperation(c16223761.spop)
	c:RegisterEffect(e1)
end
function c16223761.cfilter(c,tp)
	return c:IsPreviousPosition(POS_FACEUP) and c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_MZONE)
		and (c:GetBaseAttack()==1600 or c:GetBaseDefense()==1600)
		and (c:IsReason(REASON_BATTLE) or c:IsReason(REASON_EFFECT) and c:IsReason(REASON_DESTROY) and c:GetReasonPlayer()==1-tp)
end
function c16223761.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return eg:IsExists(c16223761.cfilter,1,nil,tp) and (c:IsLocation(LOCATION_HAND) or not eg:IsContains(c))
end
function c16223761.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and Duel.IsExistingMatchingCard(aux.TRUE,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c16223761.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_REDIRECT)
		e1:SetValue(LOCATION_REMOVED)
		c:RegisterEffect(e1,true)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,0,LOCATION_ONFIELD,1,1,nil)
		if g:GetCount()>0 then
			Duel.HintSelection(g)
			Duel.Destroy(g,REASON_EFFECT)
		end
	end
end
