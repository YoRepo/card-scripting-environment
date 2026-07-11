--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:48
-- Source DB: cards.cdb
-- Card: The Paths of Destiny  (ID: 50470982)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- Both players toss a coin once.
-- If a player's result is Heads, they gain 2000 Life Points, and if their result is Tails, they take
-- 2000 damage.
--[[ __CARD_HEADER_END__ ]]

--運命の分かれ道
function c50470982.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_COIN)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c50470982.target)
	e1:SetOperation(c50470982.activate)
	c:RegisterEffect(e1)
end
function c50470982.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,PLAYER_ALL,1)
end
function c50470982.activate(e,tp,eg,ep,ev,re,r,rp)
	local res=Duel.TossCoin(tp,1)
	if res==1 then Duel.Recover(tp,2000,REASON_EFFECT)
	else Duel.Damage(tp,2000,REASON_EFFECT) end
	res=Duel.TossCoin(1-tp,1)
	if res==1 then Duel.Recover(1-tp,2000,REASON_EFFECT)
	else Duel.Damage(1-tp,2000,REASON_EFFECT) end
end
