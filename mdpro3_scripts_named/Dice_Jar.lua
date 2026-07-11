--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Dice Jar  (ID: 3549275)
-- Type: Monster / Effect / Flip
-- Attribute: LIGHT
-- Race: Rock
-- Level: 3
-- ATK 200 | DEF 300
-- Scope: OCG / TCG
--
-- Effect Text:
-- FLIP: Both players roll a six-sided die.
-- The player with the lower result takes damage equal to their opponent's roll x 500.
-- However, if the winner rolled a 6, the loser takes 6000 damage.
-- If the rolls are the same, both players roll again.
--[[ __CARD_HEADER_END__ ]]

--ダイス・ポット
function c3549275.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DICE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c3549275.target)
	e1:SetOperation(c3549275.operation)
	c:RegisterEffect(e1)
end
function c3549275.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,PLAYER_ALL,1)
end
function c3549275.operation(e,tp,eg,ep,ev,re,r,rp)
	local d1=0
	local d2=0
	while d1==d2 do
		d1,d2=Duel.TossDice(tp,1,1)
	end
	if d1<d2 then
		if d2==6 then
			Duel.Damage(tp,6000,REASON_EFFECT)
		elseif d2>=2 and d2<=5 then
			Duel.Damage(tp,d2*500,REASON_EFFECT)
		end
	else
		if d1==6 then
			Duel.Damage(1-tp,6000,REASON_EFFECT)
		elseif d1>=2 and d1<=5 then
			Duel.Damage(1-tp,d1*500,REASON_EFFECT)
		end
	end
end
