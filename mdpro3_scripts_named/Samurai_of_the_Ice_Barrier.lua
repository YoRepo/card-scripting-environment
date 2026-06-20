--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 冰结界的武士  (ID: 64926005)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Warrior
-- Level 4
-- ATK 1800 | DEF 1500
-- Setcode: 47
--
-- Effect Text:
-- ①：表侧攻击表示的这张卡变成守备表示的场合发动。这张卡破坏，自己抽1张。
--[[ __CARD_HEADER_END__ ]]

--氷結界の武士
function c64926005.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(64926005,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_CHANGE_POS)
	e1:SetCondition(c64926005.condition)
	e1:SetTarget(c64926005.target)
	e1:SetOperation(c64926005.operation)
	c:RegisterEffect(e1)
end
function c64926005.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousPosition(POS_FACEUP_ATTACK) and c:IsPosition(POS_FACEUP_DEFENSE)
end
function c64926005.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c64926005.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.Destroy(c,REASON_EFFECT)~=0 then
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
