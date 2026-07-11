--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Meowseclick  (ID: 34198387)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Cyberse
-- Level: 4
-- ATK 1400 | DEF 1100
-- Scope: OCG / TCG
--
-- Effect Text:
-- If a Field Spell Card is activated: You can Special Summon this card from your hand, then, if
-- face-up cards are in both Field Zones, this card cannot be destroyed by battle or card effects this
-- turn.
-- You can only use this effect of "Meowseclick" once per turn.
-- During your turn, the effects of the face-up card in your opponent's Field Zone are negated.
-- During your opponent's turn, the effects of the face-up card in your Field Zone are negated.
--[[ __CARD_HEADER_END__ ]]

--ニャータリング
function c34198387.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(34198387,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,34198387)
	e1:SetCondition(c34198387.spcon)
	e1:SetTarget(c34198387.sptg)
	e1:SetOperation(c34198387.spop)
	c:RegisterEffect(e1)
	--disable self turn
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(0,LOCATION_FZONE)
	e2:SetCondition(c34198387.con1)
	e2:SetCode(EFFECT_DISABLE)
	c:RegisterEffect(e2)
	--disable oppo turn
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_FZONE,0)
	e3:SetCondition(c34198387.con2)
	e3:SetCode(EFFECT_DISABLE)
	c:RegisterEffect(e3)
end
function c34198387.spcon(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_FIELD)
end
function c34198387.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c34198387.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0
		and Duel.GetFieldGroupCount(tp,LOCATION_FZONE,LOCATION_FZONE)==2 then
			Duel.BreakEffect()
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetValue(1)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			c:RegisterEffect(e1)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
			c:RegisterEffect(e2)
	end
end
function c34198387.con1(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetTurnPlayer()==tp
end
function c34198387.con2(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetTurnPlayer()==1-tp
end
