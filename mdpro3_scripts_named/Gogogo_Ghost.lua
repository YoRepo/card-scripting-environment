--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 隆隆隆幽灵  (ID: 56105047)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Zombie
-- Level 4
-- ATK 1900 | DEF 0
-- Setcode: 89
--
-- Effect Text:
-- 这张卡特殊召唤成功的场合，可以选择自己墓地1只「隆隆隆石人」表侧守备表示特殊召唤。那之后，这张卡变成守备表示。「隆隆隆幽灵」的效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--ゴゴゴゴースト
function c56105047.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(56105047,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCountLimit(1,56105047)
	e1:SetTarget(c56105047.sptg)
	e1:SetOperation(c56105047.spop)
	c:RegisterEffect(e1)
end
function c56105047.filter(c,e,tp)
	return c:IsCode(62476815) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function c56105047.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c56105047.filter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c56105047.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c56105047.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c56105047.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP_DEFENSE)==1 then
		if c:IsPosition(POS_FACEUP_ATTACK) and c:IsRelateToEffect(e) then
			Duel.BreakEffect()
			Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
		end
	end
end
