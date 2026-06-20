--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 妖仙兽 大幽谷响  (ID: 69838592)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Beast
-- Level 6
-- ATK ? | DEF ?
-- Setcode: 179
--
-- Effect Text:
-- 「妖仙兽 大幽谷响」的①的效果1回合只能使用1次。
-- ①：对方怪兽的直接攻击宣言时从手卡把「妖仙兽 大幽谷响」以外的1只「妖仙兽」怪兽送去墓地才能发动。这张卡从手卡特殊召唤。
-- ②：这张卡和对方怪兽进行战斗的伤害步骤开始时才能发动。这张卡的攻击力·守备力直到回合结束时变成和进行战斗的对方怪兽的原本攻击力相同。
-- ③：这张卡被战斗破坏送去墓地时才能发动。从卡组把1张「妖仙兽」卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--妖仙獣 大幽谷響
function c69838592.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(69838592,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,69838592)
	e1:SetCondition(c69838592.spcon)
	e1:SetCost(c69838592.spcost)
	e1:SetTarget(c69838592.sptg)
	e1:SetOperation(c69838592.spop)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(69838592,1))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_START)
	e2:SetCondition(c69838592.condition)
	e2:SetOperation(c69838592.operation)
	c:RegisterEffect(e2)
	--tohand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(69838592,2))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_DESTROYED)
	e3:SetCondition(c69838592.thcon)
	e3:SetTarget(c69838592.thtg)
	e3:SetOperation(c69838592.thop)
	c:RegisterEffect(e3)
end
function c69838592.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp) and Duel.GetAttackTarget()==nil
end
function c69838592.cfilter(c)
	return c:IsSetCard(0xb3) and c:IsType(TYPE_MONSTER) and not c:IsCode(69838592) and c:IsAbleToGraveAsCost()
end
function c69838592.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c69838592.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c69838592.cfilter,1,1,REASON_COST)
end
function c69838592.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c69838592.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c69838592.filter(c,tc)
	if c:IsFacedown() then return false end
	return tc:GetBaseAttack()~=c:GetAttack() or tc:GetBaseAttack()~=c:GetDefense()
end
function c69838592.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return c:IsRelateToBattle() and bc and c69838592.filter(c,bc) and bc:IsFaceup() and bc:IsRelateToBattle()
end
function c69838592.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if c:IsFaceup() and c:IsRelateToBattle() and bc:IsFaceup() and bc:IsRelateToBattle() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(bc:GetBaseAttack())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_SET_DEFENSE_FINAL)
		c:RegisterEffect(e2)
	end
end
function c69838592.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c69838592.thfilter(c)
	return c:IsSetCard(0xb3) and c:IsAbleToHand()
end
function c69838592.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c69838592.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c69838592.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c69838592.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
