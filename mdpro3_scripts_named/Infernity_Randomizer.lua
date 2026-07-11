--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Infernity Randomizer  (ID: 13582837)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Warrior
-- Level: 1
-- ATK 900 | DEF 0
-- Setcode: 0xb
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn, while you have no cards in your hand, you can draw 1 card and reveal it.
-- For a Monster Card drawn with this effect, inflict damage to your opponent equal to the Level of
-- that monster x 200.
-- For a Spell or Trap Card, you take 500 damage.
--[[ __CARD_HEADER_END__ ]]

--インフェルニティ・リローダー
function c13582837.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(13582837,0))
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c13582837.spcon)
	e1:SetTarget(c13582837.sptg)
	e1:SetOperation(c13582837.spop)
	c:RegisterEffect(e1)
end
function c13582837.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)==0
end
function c13582837.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,1,tp,1)
end
function c13582837.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)~=0 then return end
	local g=Duel.GetDecktopGroup(tp,1)
	local tc=g:GetFirst()
	Duel.Draw(tp,1,REASON_EFFECT)
	if tc then
		Duel.ConfirmCards(1-tp,tc)
		Duel.BreakEffect()
		if tc:IsType(TYPE_MONSTER) then
			Duel.Damage(1-tp,tc:GetLevel()*200,REASON_EFFECT)
		else
			Duel.Damage(tp,500,REASON_EFFECT)
		end
		Duel.ShuffleHand(tp)
	end
end
