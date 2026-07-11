--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Galaxy Satellite Dragon  (ID: 92362073)
-- Type: Monster / Effect / Link
-- Attribute: DARK
-- Race: Dragon
-- Link Rating: 2
-- Link Arrows: Bottom-Left, Bottom-Right
-- ATK 2000
-- Setcode: 0x7b
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 Dragon monsters
-- During the Battle Phase (Quick Effect): You can banish this card from your field or GY, then target
-- 1 "Number" Xyz Monster you control whose original Attribute/Type are LIGHT/Dragon; until the end of
-- the Battle Phase, its ATK becomes equal to the value of the "Number" in its name x 100, also any
-- battle damage your opponent takes is halved.
-- During your opponent's End Phase: You can take 1 card from your Deck and place it on top of your
-- Deck.
-- You can only use each effect of "Galaxy Satellite Dragon" once per turn.
--[[ __CARD_HEADER_END__ ]]

--銀河衛竜
function c92362073.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkRace,RACE_DRAGON),2,2)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(92362073,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_GRAVE+LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,92362073)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(c92362073.atkcon)
	e1:SetCost(aux.bfgcost)
	e1:SetTarget(c92362073.atktg)
	e1:SetOperation(c92362073.atkop)
	c:RegisterEffect(e1)
	--deck top
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(92362073,1))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetCountLimit(1,92362074)
	e2:SetCondition(c92362073.tpcon)
	e2:SetTarget(c92362073.tptg)
	e2:SetOperation(c92362073.tpop)
	c:RegisterEffect(e2)
end
function c92362073.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE
end
function c92362073.atkfilter(c)
	local no=aux.GetXyzNumber(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsSetCard(0x48) and no
		and c:GetOriginalAttribute()==ATTRIBUTE_LIGHT and c:GetOriginalRace()==RACE_DRAGON
end
function c92362073.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c92362073.atkfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c92362073.atkfilter,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c92362073.atkfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c92362073.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	local no=aux.GetXyzNumber(tc)
	if no and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(no*100)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_BATTLE)
		tc:RegisterEffect(e1)
	end
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CHANGE_BATTLE_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(0,1)
	e2:SetValue(HALF_DAMAGE)
	e2:SetReset(RESET_PHASE+PHASE_BATTLE)
	Duel.RegisterEffect(e2,tp)
end
function c92362073.tpcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c92362073.tptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_DECK,0,1,nil)
		and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>1 end
end
function c92362073.tpop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(92362073,2))
	local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.ShuffleDeck(tp)
		Duel.MoveSequence(tc,SEQ_DECKTOP)
	end
end
