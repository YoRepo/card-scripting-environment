--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: White Rose Cloister  (ID: 84335863)
-- Type: Spell / Field
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control no monsters: You can Special Summon 1 "Rose Dragon" monster or 1 Plant monster from
-- your hand.
-- You can only use this effect of "White Rose Cloister" once per turn.
-- During your Draw Phase, before you draw: You can declare 1 card type (Monster, Spell, or Trap);
-- reveal the top card of your Deck, and if it is the declared card type, apply this effect for the
-- rest of this turn (even if this card leaves the field).
-- ● Level 7 or higher Synchro Monsters you control gain 1000 ATK.
--[[ __CARD_HEADER_END__ ]]

--白薔薇の回廊
function c84335863.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(84335863,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1,84335863)
	e2:SetCondition(c84335863.spcon)
	e2:SetTarget(c84335863.sptg)
	e2:SetOperation(c84335863.spop)
	c:RegisterEffect(e2)
	--confirm deck
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(84335863,1))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_PREDRAW)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCondition(c84335863.cfcon)
	e3:SetTarget(c84335863.cftg)
	e3:SetOperation(c84335863.cfop)
	c:RegisterEffect(e3)
end
function c84335863.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function c84335863.spfilter(c,e,tp)
	return (c:IsSetCard(0x1123) or c:IsRace(RACE_PLANT)) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c84335863.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c84335863.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c84335863.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c84335863.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c84335863.cfcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0
end
function c84335863.cftg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CARDTYPE)
	e:SetLabel(Duel.AnnounceType(tp))
end
function c84335863.cfop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)<=0 then return end
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1)
	local tc=g:GetFirst()
	local opt=e:GetLabel()
	if (opt==0 and tc:IsType(TYPE_MONSTER)) or (opt==1 and tc:IsType(TYPE_SPELL)) or (opt==2 and tc:IsType(TYPE_TRAP)) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_PHASE+PHASE_END)
		e1:SetValue(1000)
		e1:SetTargetRange(LOCATION_MZONE,0)
		e1:SetTarget(c84335863.atktg)
		Duel.RegisterEffect(e1,tp)
	end
end
function c84335863.atktg(e,c)
	return c:IsFaceup() and c:IsLevelAbove(7) and c:IsType(TYPE_SYNCHRO)
end
