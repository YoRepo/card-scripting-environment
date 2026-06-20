--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 暗绿芽  (ID: 50164989)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Plant
-- Level 2
-- ATK 0 | DEF 1000
--
-- Effect Text:
-- 自己场上有植物族的调整召唤时，这张卡可以从墓地攻击表示特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--ダーク・ヴァージャー
function c50164989.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(50164989,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c50164989.spcon)
	e1:SetTarget(c50164989.sptg)
	e1:SetOperation(c50164989.spop)
	c:RegisterEffect(e1)
end
function c50164989.spcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return tc:IsControler(tp) and tc:IsRace(RACE_PLANT) and tc:IsType(TYPE_TUNER)
end
function c50164989.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_ATTACK) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c50164989.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_ATTACK)
	end
end
