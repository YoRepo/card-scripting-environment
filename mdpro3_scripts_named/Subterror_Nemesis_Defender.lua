--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 地中族刀匠  (ID: 68823957)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast-Warrior
-- Level 2
-- ATK 100 | DEF 2000
-- Setcode: 237
--
-- Effect Text:
-- ①：只让自己场上的里侧表示怪兽1只成为对方的效果的对象时或者被选择作为对方怪兽的攻击对象时，把手卡·场上的这张卡送去墓地，以那只里侧表示怪兽以外的自己场上1只怪兽为对象才能发动。那个对象转移为作为正确
-- 对象的那只怪兽。
-- ②：只要自己场上有里侧表示怪兽存在，这张卡不会被战斗·效果破坏。
--[[ __CARD_HEADER_END__ ]]

--サブテラーの刀匠
function c68823957.initial_effect(c)
	--replace
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(68823957,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_HAND+LOCATION_MZONE)
	e1:SetCost(c68823957.ccost)
	e1:SetTarget(c68823957.cbtg)
	e1:SetOperation(c68823957.cbop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(68823957,1))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_HAND+LOCATION_MZONE)
	e2:SetCondition(c68823957.cecon)
	e2:SetCost(c68823957.ccost)
	e2:SetTarget(c68823957.cetg)
	e2:SetOperation(c68823957.ceop)
	c:RegisterEffect(e2)
	--indes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetCondition(c68823957.indcon)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e4)
end
function c68823957.ccost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c68823957.cbfilter(c,e)
	return c:IsCanBeEffectTarget(e)
end
function c68823957.cbtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c68823957.cbfilter(chkc,e) end
	local ag=Duel.GetAttacker():GetAttackableTarget()
	local at=Duel.GetAttackTarget()
	ag:RemoveCard(at)
	if chk==0 then return Duel.GetAttacker():IsControler(1-tp) and at:IsControler(tp) and at:IsFacedown()
		and ag:IsExists(c68823957.cbfilter,1,e:GetHandler(),e) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=ag:FilterSelect(tp,c68823957.cbfilter,1,1,e:GetHandler(),e)
	Duel.SetTargetCard(g)
end
function c68823957.cbop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and not Duel.GetAttacker():IsImmuneToEffect(e) then
		Duel.ChangeAttackTarget(tc)
	end
end
function c68823957.cecon(e,tp,eg,ep,ev,re,r,rp)
	if e==re or rp~=1-tp or not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not g or g:GetCount()~=1 then return false end
	local tc=g:GetFirst()
	e:SetLabelObject(tc)
	return tc:IsLocation(LOCATION_MZONE) and tc:IsFacedown()
end
function c68823957.cefilter(c,ct,oc)
	return oc~=c and Duel.CheckChainTarget(ct,c)
end
function c68823957.cetg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c68823957.cefilter(chkc,ev,e:GetHandler()) end
	if chk==0 then return Duel.IsExistingTarget(c68823957.cefilter,tp,LOCATION_MZONE,0,1,e:GetLabelObject(),ev,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c68823957.cefilter,tp,LOCATION_MZONE,0,1,1,e:GetLabelObject(),ev,e:GetHandler())
end
function c68823957.ceop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.ChangeTargetCard(ev,Group.FromCards(tc))
	end
end
function c68823957.indcon(e)
	return Duel.IsExistingMatchingCard(Card.IsFacedown,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
