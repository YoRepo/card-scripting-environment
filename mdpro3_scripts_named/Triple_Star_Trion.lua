--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Triple Star Trion  (ID: 34796454)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Warrior
-- Level: 1
-- ATK 100 | DEF 100
-- Scope: OCG / TCG
--
-- Effect Text:
-- During the End Phase, if this card is in the Graveyard because it was sent there this turn as a
-- Tribute for a successful Tribute Summon: You can Special Summon this card from your Graveyard.
--[[ __CARD_HEADER_END__ ]]

--三連星のトリオン
function c34796454.initial_effect(c)
	--to grave
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetOperation(c34796454.regop)
	c:RegisterEffect(e1)
end
function c34796454.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsReason(REASON_SUMMON) and c:IsReason(REASON_MATERIAL) then
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(34796454,0))
		e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetCountLimit(1)
		e1:SetRange(LOCATION_GRAVE)
		e1:SetTarget(c34796454.sptg)
		e1:SetOperation(c34796454.spop)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
function c34796454.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c34796454.spop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
end
