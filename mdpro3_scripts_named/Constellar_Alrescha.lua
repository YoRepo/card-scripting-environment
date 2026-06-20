--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 星圣·外屏七  (ID: 16906241)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level 6
-- ATK 2200 | DEF 1200
-- Setcode: 83
--
-- Effect Text:
-- 这张卡召唤成功时，可以从手卡把1只名字带有「星圣」的怪兽表侧守备表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--セイクリッド・レスカ
function c16906241.initial_effect(c)
	--summon success
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(16906241,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetTarget(c16906241.sptg)
	e2:SetOperation(c16906241.spop)
	c:RegisterEffect(e2)
	c16906241.star_knight_summon_effect=e2
end
function c16906241.filter(c,e,tp)
	return c:IsSetCard(0x53) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE)
end
function c16906241.sptg(e,tp,eg,ep,ev,re,r,rp,chk,_,exc)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c16906241.filter,tp,LOCATION_HAND,0,1,exc,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c16906241.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c16906241.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
