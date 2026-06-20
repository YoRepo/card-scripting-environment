--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 荷鲁斯的加护-凯布山纳夫  (ID: 74725513)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Winged Beast
-- Level 8
-- ATK 2500 | DEF 2000
-- Setcode: 413
--
-- Effect Text:
-- 这个卡名的①的方法的特殊召唤1回合只能有1次，②的效果1回合只能使用1次。
-- ①：自己场上有「王之棺」存在的场合，这张卡可以从墓地特殊召唤。
-- ②：这张卡在怪兽区域存在的状态，自己场上的其他卡因对方的效果从场上离开的场合才能发动。这个回合中，对方怪兽不能把「荷鲁斯」怪兽作为攻击对象，对方不能把场上的「荷鲁斯」怪兽作为效果的对象。
--[[ __CARD_HEADER_END__ ]]

--ホルスの加護－ケベンセヌフ
function c74725513.initial_effect(c)
	aux.AddCodeList(c,16528181)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCountLimit(1,74725513+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c74725513.sprcon)
	c:RegisterEffect(e1)
	--Leave Field
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(74725513,1))
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,74725514)
	e2:SetCondition(c74725513.descon)
	e2:SetOperation(c74725513.desop)
	c:RegisterEffect(e2)
end
function c74725513.sprfilter(c)
	return c:IsFaceup() and c:IsCode(16528181)
end
function c74725513.sprcon(e,c)
	if c==nil then return true end
	if c:IsHasEffect(EFFECT_NECRO_VALLEY) then return false end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c74725513.sprfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c74725513.cfilter(c,tp)
	return c:IsPreviousControler(tp)
		and c:GetReasonPlayer()==1-tp and c:IsReason(REASON_EFFECT)
end
function c74725513.descon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c74725513.cfilter,1,nil,tp) and not eg:IsContains(e:GetHandler())
end
function c74725513.atlimit(e,c)
	return c:IsSetCard(0x19d) and c:IsFaceup()
end
function c74725513.desop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetValue(c74725513.atlimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c74725513.atlimit)
	e2:SetValue(aux.tgoval)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
end
