--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 伊比  (ID: 32539892)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Insect
-- Level 3
-- ATK 850 | DEF 750
--
-- Effect Text:
-- 这张卡被对方的卡的效果从手卡丢弃去墓地时，给与对方基本分1000分伤害。
--[[ __CARD_HEADER_END__ ]]

--イビー
function c32539892.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(32539892,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c32539892.drcon)
	e1:SetTarget(c32539892.drtg)
	e1:SetOperation(c32539892.drop)
	c:RegisterEffect(e1)
end
function c32539892.drcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_HAND) and bit.band(r,0x4040)==0x4040 and rp==1-tp
end
function c32539892.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1000)
end
function c32539892.drop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(1-tp,1000,REASON_EFFECT)
end
