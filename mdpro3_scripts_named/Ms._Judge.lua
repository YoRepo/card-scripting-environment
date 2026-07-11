--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Ms. Judge  (ID: 86767655)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fiend
-- Level: 4
-- ATK 1800 | DEF 600
-- Scope: OCG / TCG
--
-- Effect Text:
-- If an opponent's card effect activates, before resolving that effect, toss a coin twice, and if the
-- result is 2 Heads, negate that effect.
-- You can only use this effect of "Ms. Judge" once per turn.
--[[ __CARD_HEADER_END__ ]]

--Ms.JUDGE
function c86767655.initial_effect(c)
	--disable
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e0:SetCode(EVENT_CHAINING)
	e0:SetRange(LOCATION_MZONE)
	e0:SetOperation(aux.chainreg)
	c:RegisterEffect(e0)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCategory(CATEGORY_COIN)
	e1:SetCode(EVENT_CHAIN_SOLVING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,86767655)
	e1:SetCondition(c86767655.discon)
	e1:SetOperation(c86767655.disop)
	c:RegisterEffect(e1)
end
function c86767655.discon(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and e:GetHandler():GetFlagEffect(FLAG_ID_CHAINING)>0
end
function c86767655.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,86767655)
	local c1,c2=Duel.TossCoin(tp,2)
	if c1+c2==2 then
		Duel.NegateEffect(ev)
	end
end
