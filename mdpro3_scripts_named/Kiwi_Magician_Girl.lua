--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 奇异果魔术少女  (ID: 82627406)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Spellcaster
-- Level 5
-- ATK 1800 | DEF 1200
-- Setcode: 8354
--
-- Effect Text:
-- ①：把这张卡从手卡丢弃才能发动。自己场上的「魔术少女」怪兽的攻击力·守备力直到回合结束时上升双方的场上·墓地的「魔术少女」怪兽种类×300。这个效果在对方回合也能发动。
-- ②：只要这张卡在怪兽区域存在，自己场上的魔法师族怪兽不会被效果破坏，不会成为对方的效果的对象。
--[[ __CARD_HEADER_END__ ]]

--キウイ・マジシャン・ガール
function c82627406.initial_effect(c)
	--atk up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(82627406,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_HAND)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(aux.dscon)
	e1:SetCost(c82627406.cost)
	e1:SetTarget(c82627406.target)
	e1:SetOperation(c82627406.operation)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_SPELLCASTER))
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--cannot be target
	local e3=e2:Clone()
	e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetValue(aux.tgoval)
	c:RegisterEffect(e3)
end
function c82627406.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsDiscardable() end
	Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
end
function c82627406.atkfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x20a2)
end
function c82627406.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c82627406.atkfilter,tp,LOCATION_MZONE,0,1,nil) end
end
function c82627406.ctfilter(c)
	return (c:IsLocation(LOCATION_GRAVE) or c:IsFaceup()) and c:IsType(TYPE_MONSTER) and c:IsSetCard(0x20a2)
end
function c82627406.operation(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetMatchingGroup(c82627406.atkfilter,tp,LOCATION_MZONE,0,nil)
	local g=Duel.GetMatchingGroup(c82627406.ctfilter,tp,LOCATION_MZONE+LOCATION_GRAVE,LOCATION_MZONE+LOCATION_GRAVE,nil)
	if tg:GetCount()>0 and g:GetCount()>0 then
		local d=g:GetClassCount(Card.GetCode)*300
		local sc=tg:GetFirst()
		while sc do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			e1:SetValue(d)
			sc:RegisterEffect(e1)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_UPDATE_DEFENSE)
			sc:RegisterEffect(e2)
			sc=tg:GetNext()
		end
	end
end
