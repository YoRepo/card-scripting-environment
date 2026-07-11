--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Raidraptor - Avenge Vulture  (ID: 10194329)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Winged Beast
-- Level: 4
-- ATK 1700 | DEF 100
-- Setcode: 0xba
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you take damage: You can Special Summon this card from your hand, also you cannot Special Summon
-- monsters from the Extra Deck for the rest of this turn, except "Raidraptor" monsters.
--[[ __CARD_HEADER_END__ ]]

--RR－アベンジ・ヴァルチャー
function c10194329.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_DELAY)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c10194329.condition)
	e1:SetTarget(c10194329.target)
	e1:SetOperation(c10194329.operation)
	c:RegisterEffect(e1)
end
function c10194329.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and bit.band(r,REASON_BATTLE+REASON_EFFECT)~=0
end
function c10194329.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c10194329.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c10194329.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c10194329.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsSetCard(0xba) and c:IsLocation(LOCATION_EXTRA)
end
