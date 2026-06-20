--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 吸血鬼巫师  (ID: 88728507)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Zombie
-- Level 4
-- ATK 1500 | DEF 1500
-- Setcode: 142
--
-- Effect Text:
-- ①：这张卡被对方送去墓地的场合才能发动。从卡组把1只暗属性「吸血鬼」怪兽或者1张「吸血鬼」魔法·陷阱卡加入手卡。
-- ②：把墓地的这张卡除外才能发动。这个回合只有1次，自己在5星以上的暗属性「吸血鬼」怪兽召唤的场合需要的解放可以不用。
--[[ __CARD_HEADER_END__ ]]

--ヴァンパイア・ソーサラー
function c88728507.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(88728507,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c88728507.condition)
	e1:SetTarget(c88728507.target)
	e1:SetOperation(c88728507.operation)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(88728507,1))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCost(aux.bfgcost)
	e2:SetOperation(c88728507.sumop)
	c:RegisterEffect(e2)
end
function c88728507.condition(e,tp,eg,ep,ev,re,r,rp)
	return rp==1-tp and e:GetHandler():IsPreviousControler(tp)
end
function c88728507.filter(c)
	return c:IsSetCard(0x8e) and (c:IsType(TYPE_SPELL+TYPE_TRAP) or c:IsAttribute(ATTRIBUTE_DARK)) and c:IsAbleToHand()
end
function c88728507.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c88728507.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c88728507.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c88728507.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c88728507.sumop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,88728507)==0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetDescription(aux.Stringid(88728507,2))
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetTargetRange(LOCATION_HAND,0)
		e1:SetCode(EFFECT_SUMMON_PROC)
		e1:SetCountLimit(1)
		e1:SetCondition(c88728507.ntcon)
		e1:SetTarget(c88728507.nttg)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
		Duel.RegisterFlagEffect(tp,88728507,RESET_PHASE+PHASE_END,0,1)
	end
end
function c88728507.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c88728507.nttg(e,c)
	return c:IsLevelAbove(5) and c:IsSetCard(0x8e) and c:IsAttribute(ATTRIBUTE_DARK)
end
