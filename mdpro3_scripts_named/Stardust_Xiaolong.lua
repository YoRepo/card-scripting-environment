--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Stardust Xiaolong  (ID: 68543408)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Dragon
-- Level: 1
-- ATK 100 | DEF 100
-- Setcode: 0xa3
-- Scope: OCG / TCG
--
-- Effect Text:
-- When you Synchro Summon "Stardust Dragon": You can Special Summon this card from your GY in Attack
-- Position.
-- Each turn, the first time this card would be destroyed by battle, it is not destroyed.
--[[ __CARD_HEADER_END__ ]]

--スターダスト・シャオロン
function c68543408.initial_effect(c)
	aux.AddCodeList(c,44508094)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(68543408,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c68543408.spcon)
	e1:SetTarget(c68543408.sptg)
	e1:SetOperation(c68543408.spop)
	c:RegisterEffect(e1)
	--battle indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e2:SetCountLimit(1)
	e2:SetValue(c68543408.valcon)
	c:RegisterEffect(e2)
end
function c68543408.spcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return tc:IsControler(tp) and tc:IsCode(44508094) and tc:IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c68543408.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_ATTACK) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c68543408.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_ATTACK)
	end
end
function c68543408.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end
