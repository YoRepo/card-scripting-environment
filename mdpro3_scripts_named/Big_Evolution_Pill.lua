--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 大进化药  (ID: 84808313)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 270
--
-- Effect Text:
-- 把自己场上1只恐龙族怪兽解放才能把这张卡发动。这张卡发动后继续留在场上，用对方回合计算的第3回合的对方结束阶段破坏。
-- ①：只要这张卡在魔法与陷阱区域存在，自己在5星以上的恐龙族怪兽召唤的场合需要的解放可以不用。
--[[ __CARD_HEADER_END__ ]]

--大進化薬
function c84808313.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c84808313.cost)
	e1:SetTarget(c84808313.target)
	c:RegisterEffect(e1)
	--reduce tribute
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(84808313,0))
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SUMMON_PROC)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_HAND,0)
	e2:SetCondition(c84808313.ntcon)
	e2:SetTarget(c84808313.nttg)
	c:RegisterEffect(e2)
	--remain field
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_REMAIN_FIELD)
	c:RegisterEffect(e3)
end
function c84808313.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsRace,1,nil,RACE_DINOSAUR) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsRace,1,1,nil,RACE_DINOSAUR)
	Duel.Release(g,REASON_COST)
end
function c84808313.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local c=e:GetHandler()
	c:SetTurnCounter(0)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCondition(c84808313.descon)
	e1:SetOperation(c84808313.desop)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e1)
end
function c84808313.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c84808313.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=c:GetTurnCounter()
	ct=ct+1
	c:SetTurnCounter(ct)
	if ct==3 then
		Duel.Destroy(c,REASON_RULE)
	end
end
function c84808313.ntcon(e,c,minc)
	if c==nil then return true end
	return e:GetHandler():GetType()==TYPE_SPELL
		and minc==0 and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c84808313.nttg(e,c)
	return c:IsLevelAbove(5) and c:IsRace(RACE_DINOSAUR)
end
