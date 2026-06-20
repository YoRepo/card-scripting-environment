--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 强欲的碎片  (ID: 33904024)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：只要这张卡在魔法与陷阱区域存在，每次自己抽卡阶段通常抽卡，给这张卡放置1个强欲指示物。
-- ②：把有强欲指示物2个以上放置的这张卡送去墓地才能发动。自己从卡组抽2张。
--[[ __CARD_HEADER_END__ ]]

--強欲なカケラ
function c33904024.initial_effect(c)
	c:EnableCounterPermit(0xd)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--counter
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_DRAW)
	e2:SetRange(LOCATION_SZONE)
	e2:SetOperation(c33904024.ctop)
	c:RegisterEffect(e2)
	--draw
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(33904024,0))
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c33904024.drcon)
	e3:SetCost(c33904024.drcost)
	e3:SetTarget(c33904024.drtg)
	e3:SetOperation(c33904024.drop)
	c:RegisterEffect(e3)
end
function c33904024.ctop(e,tp,eg,ep,ev,re,r,rp)
	if ep==tp and r==REASON_RULE then
		e:GetHandler():AddCounter(0xd,1)
	end
end
function c33904024.drcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetCounter(0xd)>=2
end
function c33904024.drcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c33904024.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c33904024.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
