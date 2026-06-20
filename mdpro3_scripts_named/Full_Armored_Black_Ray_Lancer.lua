--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 重铠装-黑鳍条枪兵  (ID: 25853045)
-- Type: Monster / Effect / Xyz
-- Attribute: WATER
-- Race: Beast-Warrior
-- Rank 4
-- ATK 2100 | DEF 600
--
-- Effect Text:
-- 水属性4星怪兽×3
-- 这张卡也能在自己场上的没有超量素材的3阶水属性超量怪兽上面重叠来超量召唤。
-- ①：这张卡的攻击力上升这张卡的超量素材数量×200。
-- ②：这张卡战斗破坏对方怪兽时，以对方场上1张魔法·陷阱卡为对象才能发动。那张对方的卡破坏。
-- ③：场上的这张卡被战斗·效果破坏的场合，可以作为代替把这张卡的超量素材全部取除。
--[[ __CARD_HEADER_END__ ]]

--FA－ブラック・レイ・ランサー
function c25853045.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_WATER),4,3,c25853045.ovfilter,aux.Stringid(25853045,0))
	c:EnableReviveLimit()
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c25853045.atkval)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c25853045.reptg)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(25853045,2))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCode(EVENT_BATTLE_DESTROYING)
	e3:SetCondition(aux.bdocon)
	e3:SetTarget(c25853045.destg)
	e3:SetOperation(c25853045.desop)
	c:RegisterEffect(e3)
end
function c25853045.ovfilter(c)
	return c:IsFaceup() and c:IsRank(3) and c:IsAttribute(ATTRIBUTE_WATER) and c:GetOverlayCount()==0
end
function c25853045.atkval(e,c)
	return c:GetOverlayCount()*200
end
function c25853045.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:CheckRemoveOverlayCard(tp,1,REASON_EFFECT)
		and c:IsReason(REASON_BATTLE+REASON_EFFECT) and not c:IsReason(REASON_REPLACE) end
	if Duel.SelectEffectYesNo(tp,c,96) then
		local g=c:GetOverlayGroup()
		Duel.SendtoGrave(g,REASON_EFFECT)
		return true
	else return false end
end
function c25853045.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c25853045.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and c25853045.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c25853045.filter,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c25853045.filter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c25853045.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsControler(1-tp) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
