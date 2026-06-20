--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 燃烧拳击手 护头拳手  (ID: 79867938)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Warrior
-- Level 4
-- ATK 1000 | DEF 1800
-- Setcode: 4228
--
-- Effect Text:
-- ①：这张卡召唤时才能发动。从卡组把1只「燃烧拳击手」怪兽送去墓地。
-- ②：攻击表示的这张卡1回合只有1次不会被战斗破坏。
--[[ __CARD_HEADER_END__ ]]

--BK ヘッドギア
function c79867938.initial_effect(c)
	--send to grave
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(79867938,0))
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c79867938.target)
	e1:SetOperation(c79867938.operation)
	c:RegisterEffect(e1)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e1:SetCountLimit(1)
	e1:SetValue(c79867938.valcon)
	c:RegisterEffect(e1)
end
function c79867938.tgfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x1084) and c:IsAbleToGrave()
end
function c79867938.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c79867938.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c79867938.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c79867938.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
function c79867938.valcon(e,re,r,rp)
	return e:GetHandler():IsAttackPos() and bit.band(r,REASON_BATTLE)~=0
end
