--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Oxygeddon  (ID: 58071123)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Dinosaur
-- Level: 4
-- ATK 1800 | DEF 800
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is destroyed by battle with a Pyro monster and sent to the GY: Each player takes 800
-- damage.
--[[ __CARD_HEADER_END__ ]]

--オキシゲドン
function c58071123.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(58071123,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c58071123.damcon)
	e1:SetTarget(c58071123.damtg)
	e1:SetOperation(c58071123.damop)
	c:RegisterEffect(e1)
end
function c58071123.damcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():GetBattleTarget():IsRace(RACE_PYRO)
end
function c58071123.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,800)
end
function c58071123.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(tp,800,REASON_EFFECT,true)
	Duel.Damage(1-tp,800,REASON_EFFECT,true)
	Duel.RDComplete()
end
