--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 帝王翔风龙  (ID: 52824910)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Dragon
-- Level 6
-- ATK 2400 | DEF 2200
--
-- Effect Text:
-- ①：这张卡不会被和相同攻击力的怪兽的战斗破坏。
-- ②：这张卡被破坏送去墓地的场合，以场上1只怪兽为对象发动。那只怪兽回到持有者手卡。
--[[ __CARD_HEADER_END__ ]]

--カイザー・グライダー
function c52824910.initial_effect(c)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(c52824910.indes)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(52824910,0))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c52824910.condition)
	e2:SetTarget(c52824910.target)
	e2:SetOperation(c52824910.operation)
	c:RegisterEffect(e2)
end
function c52824910.indes(e,c)
	return c:IsAttack(e:GetHandler():GetAttack())
end
function c52824910.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_DESTROY)
end
function c52824910.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsAbleToHand() end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,Card.IsAbleToHand,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c52824910.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
