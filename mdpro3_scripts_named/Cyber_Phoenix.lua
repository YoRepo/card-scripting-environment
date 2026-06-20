--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 电子凤凰  (ID: 3370104)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Machine
-- Level 4
-- ATK 1200 | DEF 1600
-- Setcode: 147
--
-- Effect Text:
-- ①：只要这张卡在怪兽区域攻击表示存在，只以自己场上的机械族怪兽1只为对象的魔法·陷阱卡的效果无效化。
-- ②：这张卡被战斗破坏送去墓地时才能发动。自己从卡组抽1张。
--[[ __CARD_HEADER_END__ ]]

--サイバー・フェニックス
function c3370104.initial_effect(c)
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_SZONE,LOCATION_SZONE)
	e1:SetTarget(c3370104.distg)
	c:RegisterEffect(e1)
	--disable effect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAIN_SOLVING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetOperation(c3370104.disop)
	c:RegisterEffect(e2)
	--draw
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(3370104,0))
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(EVENT_BATTLE_DESTROYED)
	e3:SetCondition(c3370104.condition)
	e3:SetTarget(c3370104.target)
	e3:SetOperation(c3370104.operation)
	c:RegisterEffect(e3)
end
function c3370104.distg(e,c)
	if not e:GetHandler():IsAttackPos() or c:GetCardTargetCount()~=1 then return false end
	local tc=c:GetFirstCardTarget()
	return tc:IsControler(e:GetHandlerPlayer()) and tc:IsFaceup() and tc:IsRace(RACE_MACHINE)
end
function c3370104.disop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsAttackPos() or re:IsActiveType(TYPE_MONSTER) then return end
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not g or g:GetCount()~=1 then return end
	local tc=g:GetFirst()
	if tc:IsControler(tp) and tc:IsLocation(LOCATION_MZONE) and tc:IsFaceup() and tc:IsRace(RACE_MACHINE) then
		Duel.NegateEffect(ev)
	end
end
function c3370104.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsLocation(LOCATION_GRAVE) and c:IsReason(REASON_BATTLE) and c:IsPreviousPosition(POS_FACEUP)
end
function c3370104.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c3370104.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
