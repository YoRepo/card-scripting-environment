--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 再生木乃伊  (ID: 70821187)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Zombie
-- Level 4
-- ATK 1800 | DEF 1500
--
-- Effect Text:
-- 对方控制的卡的效果把这张卡从手卡送去墓地时，这张卡回到手卡。
--[[ __CARD_HEADER_END__ ]]

--再生ミイラ
function c70821187.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(70821187,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c70821187.condition)
	e1:SetTarget(c70821187.target)
	e1:SetOperation(c70821187.operation)
	c:RegisterEffect(e1)
end
function c70821187.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_HAND) and rp==1-tp and bit.band(r,REASON_EFFECT)==REASON_EFFECT
end
function c70821187.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c70821187.operation(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) and Duel.SendtoHand(e:GetHandler(),nil,REASON_EFFECT)==1 then
		Duel.ConfirmCards(1-tp,e:GetHandler())
	end
end
