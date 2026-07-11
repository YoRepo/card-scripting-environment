--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Hero Counterattack  (ID: 19024706)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- When an "Elemental HERO" monster you control is destroyed by battle: Your opponent chooses 1 random
-- card from your hand, then, if it is an "Elemental HERO" monster, you destroy 1 monster your opponent
-- controls, and if you do, Special Summon the chosen monster.
--[[ __CARD_HEADER_END__ ]]

--ヒーロー逆襲
function c19024706.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c19024706.condition)
	e1:SetTarget(c19024706.target)
	e1:SetOperation(c19024706.activate)
	c:RegisterEffect(e1)
end
function c19024706.cfilter(c,tp)
	return c:IsSetCard(0x3008) and c:IsPreviousControler(tp)
end
function c19024706.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c19024706.cfilter,1,nil,tp)
end
function c19024706.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_HAND,0,1,nil,0x3008) end
end
function c19024706.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	local sg=g:RandomSelect(1-tp,1)
	local tc=sg:GetFirst()
	if tc then
		Duel.ConfirmCards(1-tp,tc)
		if tc:IsSetCard(0x3008) and tc:IsType(TYPE_MONSTER) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
			local dg=Duel.SelectMatchingCard(tp,aux.TRUE,tp,0,LOCATION_MZONE,1,1,nil)
			Duel.Destroy(dg,REASON_EFFECT)
			if Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)==0 then
				Duel.ShuffleHand(tp)
			end
		else
			Duel.ShuffleHand(tp)
		end
	end
end
