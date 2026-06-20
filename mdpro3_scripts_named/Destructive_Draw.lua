--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 步向破灭的速攻抽卡  (ID: 77859858)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 双方玩家在抽卡阶段开始时手卡是0张的场合，通常抽卡外可以再抽1张。这张卡的控制者在每次自己回合的结束阶段支付700基本分。这个时候基本分700未满的场合，基本分变成0。自己场上表侧表示存在的这张卡从场
-- 上离开时，自己受到3000分伤害。
--[[ __CARD_HEADER_END__ ]]

--破滅へのクイック・ドロー
function c77859858.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--leave
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_LEAVE_FIELD_P)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetOperation(c77859858.checkop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetOperation(c77859858.leave)
	e3:SetLabelObject(e2)
	c:RegisterEffect(e3)
	--Draw
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_PREDRAW)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetOperation(c77859858.pdraw)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(77859858,0))
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e5:SetCategory(CATEGORY_DRAW)
	e5:SetRange(LOCATION_SZONE)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e5:SetCode(EVENT_DRAW)
	e5:SetCondition(c77859858.drcon)
	e5:SetTarget(c77859858.drtg)
	e5:SetOperation(c77859858.drop)
	e5:SetLabelObject(e4)
	c:RegisterEffect(e5)
	--cost
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e6:SetRange(LOCATION_SZONE)
	e6:SetCode(EVENT_PHASE+PHASE_END)
	e6:SetCountLimit(1)
	e6:SetCondition(c77859858.costcon)
	e6:SetOperation(c77859858.costop)
	c:RegisterEffect(e6)
end
function c77859858.checkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsDisabled() or not c:IsStatus(STATUS_EFFECT_ENABLED) then
		e:SetLabel(1)
	else e:SetLabel(0) end
end
function c77859858.leave(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if e:GetLabelObject():GetLabel()==0 and c:IsPreviousControler(tp) then
		Duel.Damage(tp,3000,REASON_EFFECT)
	end
end
function c77859858.pdraw(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(ep,LOCATION_HAND,0)==0 then e:SetLabel(1)
	else e:SetLabel(0) end
end
function c77859858.drcon(e,tp,eg,ep,ev,re,r,rp)
	return r==REASON_RULE and e:GetLabelObject():GetLabel()==1
end
function c77859858.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(ep)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,ep,1)
end
function c77859858.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c77859858.costcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c77859858.costop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLP(tp)>=700 then
		Duel.PayLPCost(tp,700)
	else
		Duel.SetLP(tp,0)
	end
end
