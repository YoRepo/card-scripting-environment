--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Abare Ushioni  (ID: 89718302)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast-Warrior
-- Level: 4
-- ATK 1200 | DEF 1200
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn, you can toss a coin and call it.
-- If you call it right, inflict 1000 damage to your opponent.
-- If you call it wrong, you take 1000 damage.
--[[ __CARD_HEADER_END__ ]]

--暴れ牛鬼
function c89718302.initial_effect(c)
	--coin
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(89718302,0))
	e1:SetCategory(CATEGORY_COIN+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c89718302.damtg)
	e1:SetOperation(c89718302.damop)
	c:RegisterEffect(e1)
end
function c89718302.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
end
function c89718302.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_COIN)
	local coin=Duel.AnnounceCoin(tp)
	local res=Duel.TossCoin(tp,1)
	if coin~=res then
		Duel.Damage(1-tp,1000,REASON_EFFECT)
	else
		Duel.Damage(tp,1000,REASON_EFFECT)
	end
end
