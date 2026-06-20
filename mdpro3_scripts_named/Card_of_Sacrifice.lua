--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 舍身的宝札  (ID: 88513608)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上表侧攻击表示存在的怪兽2只以上的攻击力合计比对方场上表侧表示存在的攻击力最低的怪兽低的场合，从自己卡组抽2张卡。这张卡发动的回合，自己不能把怪兽召唤·反转召唤·特殊召唤，也不能把表示形式变更。
--[[ __CARD_HEADER_END__ ]]

--捨て身の宝札
function c88513608.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c88513608.condition)
	e1:SetCost(c88513608.cost)
	e1:SetTarget(c88513608.target)
	e1:SetOperation(c88513608.activate)
	c:RegisterEffect(e1)
	if not c88513608.global_check then
		c88513608.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_CHANGE_POS)
		ge1:SetOperation(c88513608.poscheck)
		Duel.RegisterEffect(ge1,0)
	end
end
function c88513608.poscheck(e,tp,eg,ep,ev,re,r,rp)
	if re==nil then
		Duel.RegisterFlagEffect(rp,88513608,RESET_PHASE+PHASE_END,0,1)
	end
end
function c88513608.check(tp)
	local sg=Duel.GetMatchingGroup(Card.IsPosition,tp,LOCATION_MZONE,0,nil,POS_FACEUP_ATTACK)
	if sg:GetCount()<2 then return false end
	local og=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
	if og:GetCount()==0 then return false end
	local at1=sg:GetSum(Card.GetAttack)
	local tg,at2=og:GetMinGroup(Card.GetAttack)
	return at1<at2
end
function c88513608.condition(e,tp,eg,ep,ev,re,r,rp)
	return c88513608.check(tp)
end
function c88513608.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetActivityCount(tp,ACTIVITY_SUMMON)==0
		and Duel.GetActivityCount(tp,ACTIVITY_FLIPSUMMON)==0
		and Duel.GetActivityCount(tp,ACTIVITY_SPSUMMON)==0
		and Duel.GetFlagEffect(tp,88513608)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_SUMMON)
	Duel.RegisterEffect(e2,tp)
	local e3=e1:Clone()
	e3:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
	Duel.RegisterEffect(e3,tp)
	local e4=Effect.CreateEffect(e:GetHandler())
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_OATH)
	e4:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	e4:SetReset(RESET_PHASE+PHASE_END)
	e4:SetTargetRange(LOCATION_MZONE,0)
	Duel.RegisterEffect(e4,tp)
end
function c88513608.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c88513608.activate(e,tp,eg,ep,ev,re,r,rp)
	if not c88513608.check(tp) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
