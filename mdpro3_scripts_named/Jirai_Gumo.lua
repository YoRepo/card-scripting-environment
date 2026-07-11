--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Jirai Gumo  (ID: 94773007)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Insect
-- Level: 4
-- ATK 2200 | DEF 100
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card declares an attack: Toss a coin and call it.
-- If you call it wrong, lose half your LP.
--[[ __CARD_HEADER_END__ ]]

--地雷蜘蛛
function c94773007.initial_effect(c)
	--coin
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(94773007,0))
	e1:SetCategory(CATEGORY_COIN)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetTarget(c94773007.attg)
	e1:SetOperation(c94773007.atop)
	c:RegisterEffect(e1)
end
function c94773007.attg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
end
function c94773007.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_COIN)
	local opt=Duel.AnnounceCoin(tp)
	local coin=Duel.TossCoin(tp,1)
	if opt==coin then
		Duel.SetLP(tp,math.ceil(Duel.GetLP(tp)/2))
	end
end
