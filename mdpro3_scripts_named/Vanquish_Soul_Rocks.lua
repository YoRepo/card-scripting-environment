--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 征服斗魂 洛克斯  (ID: 77894049)
-- Type: Monster / Effect / Xyz
-- Attribute: DARK
-- Race: Pyro
-- Rank 4
-- ATK 2000 | DEF 2500
-- Setcode: 405
--
-- Effect Text:
-- 4星「征服斗魂」怪兽×2只以上
-- 「征服斗魂 洛克斯」在「征服斗魂」怪兽进行过战斗的回合有1次也能在自己场上的「征服斗魂」怪兽或「斗神的虚像」上面重叠来超量召唤。
-- ①：这张卡作为超量素材中的怪兽属性让这张卡得到以下效果。
-- ●暗：对方场上的怪兽的攻击力下降800。
-- ●炎：自己场上的「征服斗魂」怪兽的攻击力上升1000。
-- ●地：把这张卡1个超量素材取除才能发动。对方场上1张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--VS ロックス
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,28168628)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x195),4,2,s.ovfilter,aux.Stringid(id,0),99,s.xyzop)
	c:EnableReviveLimit()
	--atkdown
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetValue(-800)
	e1:SetCondition(s.atkcon1)
	c:RegisterEffect(e1)
	--atkup
	local e2=e1:Clone()
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x195))
	e2:SetValue(1000)
	e2:SetCondition(s.atkcon2)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,1))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(s.atkcon3)
	e3:SetCost(s.cost)
	e3:SetTarget(s.target)
	e3:SetOperation(s.operation)
	c:RegisterEffect(e3)
	if not s.global_check then
		s.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_BATTLED)
		ge1:SetOperation(s.checkop)
		Duel.RegisterEffect(ge1,0)
	end
end
function s.ovfilter(c)
	return c:IsFaceup() and (c:IsSetCard(0x195) or c:IsCode(28168628))
end
function s.atkcon1(e)
	return e:GetHandler():GetOverlayGroup():IsExists(Card.IsAttribute,1,nil,ATTRIBUTE_DARK)
end
function s.atkcon2(e)
	return e:GetHandler():GetOverlayGroup():IsExists(Card.IsAttribute,1,nil,ATTRIBUTE_FIRE)
end
function s.atkcon3(e)
	return e:GetHandler():GetOverlayGroup():IsExists(Card.IsAttribute,1,nil,ATTRIBUTE_EARTH)
end
function s.xyzop(e,tp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,id)>0 and Duel.GetFlagEffect(tp,id+o)==0 end
	Duel.RegisterFlagEffect(tp,id+o,RESET_PHASE+PHASE_END,EFFECT_FLAG_OATH,1)
end
function s.check(c)
	return c and c:IsSetCard(0x195)
end
function s.checkop(e,tp,eg,ep,ev,re,r,rp)
	if s.check(Duel.GetAttacker()) or s.check(Duel.GetAttackTarget()) then
		Duel.RegisterFlagEffect(tp,id,RESET_PHASE+PHASE_END,0,1)
		Duel.RegisterFlagEffect(1-tp,id,RESET_PHASE+PHASE_END,0,1)
	end
end
function s.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(nil,tp,0,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(nil,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function s.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(1-tp,LOCATION_ONFIELD,0)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g2=Duel.SelectMatchingCard(tp,nil,tp,0,LOCATION_ONFIELD,1,1,nil)
		Duel.HintSelection(g2)
		Duel.Destroy(g2,REASON_EFFECT)
	end
end
