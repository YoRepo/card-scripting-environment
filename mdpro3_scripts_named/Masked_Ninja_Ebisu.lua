--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 覆面忍者 惠比寿  (ID: 22512406)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Warrior
-- Level 4
-- ATK 1200 | DEF 1800
-- Setcode: 43
--
-- Effect Text:
-- 1回合1次，自己场上有「覆面忍者 惠比寿」以外的名字带有「忍者」的怪兽存在的场合才能发动。自己场上的名字带有「忍者」的怪兽数量的对方魔法·陷阱卡回到持有者手卡。这个效果适用的回合，自己场上的「忍者义贼
-- 五卫五卫」可以直接攻击对方玩家。
--[[ __CARD_HEADER_END__ ]]

--覆面忍者ヱビス
function c22512406.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(22512406,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c22512406.thcon)
	e1:SetTarget(c22512406.thtg)
	e1:SetOperation(c22512406.thop)
	c:RegisterEffect(e1)
end
function c22512406.cfilter1(c)
	return c:IsFaceup() and c:IsSetCard(0x2b) and not c:IsCode(22512406)
end
function c22512406.cfilter2(c)
	return c:IsFaceup() and c:IsSetCard(0x2b)
end
function c22512406.thcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c22512406.cfilter1,tp,LOCATION_MZONE,0,1,nil)
end
function c22512406.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToHand()
end
function c22512406.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local ct=Duel.GetMatchingGroupCount(c22512406.cfilter2,tp,LOCATION_MZONE,0,nil)
		local dt=Duel.GetMatchingGroupCount(c22512406.filter,tp,0,LOCATION_ONFIELD,nil)
		e:SetLabel(ct)
		return dt>=ct
	end
	local g=Duel.GetMatchingGroup(c22512406.filter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,e:GetLabel(),0,0)
end
function c22512406.thop(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(c22512406.cfilter2,tp,LOCATION_MZONE,0,nil)
	local g=Duel.GetMatchingGroup(c22512406.filter,tp,0,LOCATION_ONFIELD,nil)
	if ct>g:GetCount() then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local sg=g:Select(tp,ct,ct,nil)
	Duel.SendtoHand(sg,nil,REASON_EFFECT)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsCode,10236520))
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
