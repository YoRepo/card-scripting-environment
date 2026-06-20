--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 未来No.0 未来皇 霍普·异热同心  (ID: 41522092)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Warrior
-- Rank 1
-- ATK 0 | DEF 0
-- Setcode: 541711073352
--
-- Effect Text:
-- 相同阶级的超量怪兽×2
-- 规则上，这张卡的阶级当作1阶使用。
-- ①：这张卡的攻击力·守备力上升自己场上以及对方墓地的超量怪兽的阶级合计×500。
-- ②：对方怪兽不能选择其他怪兽作为攻击对象，对方不能把场上的其他卡作为效果的对象。
-- ③：1回合1次，对方在场上把效果发动时，把这张卡1个超量素材取除才能发动。得到对方场上1只怪兽的控制权。这个回合，这张卡不会被战斗·效果破坏。
--[[ __CARD_HEADER_END__ ]]

--FNo.0 未来皇ホープ・ゼアル
local s,id,o=GetID()
function s.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedureLevelFree(c,s.mfilter,s.xyzcheck,2,2)
	c:EnableReviveLimit()
	--atk def up
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetValue(s.atkval)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e2)
	--atk limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e3:SetValue(s.atlimit)
	c:RegisterEffect(e3)
	--cannot be target
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e4:SetRange(LOCATION_MZONE)
	e4:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SET_AVAILABLE)
	e4:SetTargetRange(LOCATION_ONFIELD,LOCATION_ONFIELD)
	e4:SetTarget(s.tgtg)
	e4:SetValue(aux.tgoval)
	c:RegisterEffect(e4)
	--control
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(id,1))
	e5:SetCategory(CATEGORY_CONTROL)
	e5:SetType(EFFECT_TYPE_QUICK_O)
	e5:SetCode(EVENT_CHAINING)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1)
	e5:SetCondition(s.ctcon)
	e5:SetCost(s.ctcost)
	e5:SetTarget(s.cttg)
	e5:SetOperation(s.ctop)
	c:RegisterEffect(e5)
end
aux.xyz_number[id]=0
function s.mfilter(c,xyzc)
	return c:IsXyzType(TYPE_XYZ)
end
function s.xyzcheck(g)
	return g:GetClassCount(Card.GetRank)==1
end
function s.atkfilter(c)
	return c:IsFaceupEx() and c:IsType(TYPE_XYZ)
end
function s.atkval(e,c)
	local g=Duel.GetMatchingGroup(s.atkfilter,c:GetControler(),LOCATION_MZONE,LOCATION_GRAVE,nil)
	return g:GetSum(Card.GetRank)*500
end
function s.atlimit(e,c)
	return c~=e:GetHandler()
end
function s.tgtg(e,c)
	return c~=e:GetHandler()
end
function s.ctcon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED)
		and ep==1-tp
		and ((re:GetActivateLocation()&LOCATION_ONFIELD)>0 or re:IsHasType(EFFECT_TYPE_ACTIVATE))
end
function s.ctcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function s.tgfilter(c)
	return c:IsControlerCanBeChanged()
end
function s.cttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.tgfilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,nil,1,1-tp,LOCATION_MZONE)
end
function s.ctop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectMatchingCard(tp,s.tgfilter,tp,0,LOCATION_MZONE,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.HintSelection(g)
		Duel.GetControl(tc,tp)
	end
	if c:IsRelateToChain() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		c:RegisterEffect(e2)
	end
end
