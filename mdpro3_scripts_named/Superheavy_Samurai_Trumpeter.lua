--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Superheavy Samurai Trumpeter  (ID: 64373401)
-- Type: Monster / Effect / Tuner
-- Attribute: EARTH
-- Race: Machine
-- Level: 2
-- ATK 300 | DEF 600
-- Setcode: 0x9a
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you have no Spell/Trap Cards in your Graveyard, you can Special Summon this card (from your
-- hand).
-- After this card was Special Summoned this way, you cannot Special Summon monsters for the rest of
-- this turn, except "Superheavy Samurai" monsters.
-- If this card is Tributed for the Tribute Summon of a "Superheavy Samurai" monster and sent to the
-- Graveyard, and you have no Spell/Trap Cards in your Graveyard: You can Special Summon this card.
--[[ __CARD_HEADER_END__ ]]

--超重武者ホラガ－E
function c64373401.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c64373401.hspcon)
	e1:SetOperation(c64373401.hspop)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(64373401,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BE_MATERIAL)
	e2:SetCondition(c64373401.spcon)
	e2:SetTarget(c64373401.sptg)
	e2:SetOperation(c64373401.spop)
	c:RegisterEffect(e2)
end
function c64373401.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c64373401.hspcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and not Duel.IsExistingMatchingCard(c64373401.filter,tp,LOCATION_GRAVE,0,1,nil)
end
function c64373401.hspop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c64373401.splimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c64373401.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return not c:IsSetCard(0x9a)
end
function c64373401.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsLocation(LOCATION_GRAVE) and r==REASON_SUMMON and c:GetReasonCard():IsSetCard(0x9a)
		and not Duel.IsExistingMatchingCard(c64373401.filter,tp,LOCATION_GRAVE,0,1,nil)
end
function c64373401.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c64373401.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
