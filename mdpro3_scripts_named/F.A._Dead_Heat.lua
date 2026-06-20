--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 方程式运动员白热阶段  (ID: 5641251)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
-- Setcode: 263
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：对方怪兽的直接攻击宣言时才能发动。从卡组把1只「方程式运动员」怪兽特殊召唤。
-- ②：自己的「方程式运动员」怪兽和对方怪兽进行战斗的伤害计算前才能发动1次。双方各掷1次骰子。自己的出现数目比对方大的场合，那只进行战斗的自己怪兽的等级直到回合结束时上升4星。自己的出现数目比对方小的场
-- 合，那只自己怪兽破坏。出现的数目相同的场合，重掷骰子。
--[[ __CARD_HEADER_END__ ]]

--F.A.デッド・ヒート
function c5641251.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(5641251,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,5641251)
	e2:SetCondition(c5641251.spcon)
	e2:SetTarget(c5641251.sptg)
	e2:SetOperation(c5641251.spop)
	c:RegisterEffect(e2)
	--atk up
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(5641251,1))
	e3:SetCategory(CATEGORY_DICE+CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_CONFIRM)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c5641251.lvlcon)
	e3:SetOperation(c5641251.lvlop)
	c:RegisterEffect(e3)
end
function c5641251.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp) and Duel.GetAttackTarget()==nil
end
function c5641251.spfilter(c,e,tp)
	return c:IsSetCard(0x107) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP)
end
function c5641251.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c5641251.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c5641251.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c5641251.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c5641251.lvlcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	local bc=Duel.GetAttackTarget()
	if not bc then return false end
	if tc:IsControler(1-tp) then bc,tc=tc,bc end
	return bc:IsFaceup() and tc:IsFaceup() and tc:IsSetCard(0x107)
end
function c5641251.lvlop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetAttacker()
	local bc=Duel.GetAttackTarget()
	if not bc then return false end
	if tc:IsControler(1-tp) then bc,tc=tc,bc end
	local d1=0
	local d2=0
	while d1==d2 do
		d1,d2=Duel.TossDice(tp,1,1)
	end
	if d1>d2 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(4)
		tc:RegisterEffect(e1)
	else
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
