--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 强欲之喜  (ID: 3972721)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己把对方场上表侧表示存在的同调怪兽战斗或者卡的效果破坏的回合才能发动。从自己卡组抽2张卡。
--[[ __CARD_HEADER_END__ ]]

--グリード・グラード
function c3972721.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_END_PHASE)
	e1:SetCondition(c3972721.condition)
	e1:SetTarget(c3972721.target)
	e1:SetOperation(c3972721.activate)
	c:RegisterEffect(e1)
	if not c3972721.global_check then
		c3972721.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DESTROYED)
		ge1:SetOperation(c3972721.checkop)
		Duel.RegisterEffect(ge1,0)
	end
end
function c3972721.checkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local p1=false
	local p2=false
	while tc do
		if tc:IsType(TYPE_SYNCHRO) and tc:IsPreviousLocation(LOCATION_MZONE)
			and ((tc:IsReason(REASON_BATTLE) and bit.band(tc:GetBattlePosition(),POS_FACEUP)~=0)
			or (not tc:IsReason(REASON_BATTLE) and tc:IsPreviousPosition(POS_FACEUP)))
			and tc:GetPreviousControler()~=tc:GetReasonPlayer() then
			if tc:GetReasonPlayer()==0 then p1=true else p2=true end
		end
		tc=eg:GetNext()
	end
	if p1 then Duel.RegisterFlagEffect(0,3972721,RESET_PHASE+PHASE_END,0,1) end
	if p2 then Duel.RegisterFlagEffect(1,3972721,RESET_PHASE+PHASE_END,0,1) end
end
function c3972721.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(tp,3972721)~=0
end
function c3972721.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c3972721.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
