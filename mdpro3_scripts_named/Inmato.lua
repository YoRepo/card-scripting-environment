--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 番茄小子  (ID: 39703254)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Plant
-- Level 3
-- ATK 1400 | DEF 800
-- Setcode: 91
--
-- Effect Text:
-- 场上表侧表示存在的这张卡以外的1只植物族怪兽成为对方的魔法·陷阱卡的效果的对象时才能发动。把自己场上存在的这张卡解放，从自己卡组抽2张卡。
--[[ __CARD_HEADER_END__ ]]

--トマボー
function c39703254.initial_effect(c)
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(39703254,0))
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c39703254.condition)
	e1:SetCost(c39703254.cost)
	e1:SetTarget(c39703254.target)
	e1:SetOperation(c39703254.operation)
	c:RegisterEffect(e1)
end
function c39703254.condition(e,tp,eg,ep,ev,re,r,rp)
	if rp==tp or not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	if not re:IsActiveType(TYPE_SPELL+TYPE_TRAP) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not g or g:GetCount()~=1 then return false end
	local tg=g:GetFirst()
	local c=e:GetHandler()
	return tg~=c and tg:IsFaceup() and tg:IsRace(RACE_PLANT)
end
function c39703254.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c39703254.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c39703254.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
