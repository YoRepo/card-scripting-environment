--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 新空间侠·闪烁青苔  (ID: 13857930)
-- Type: Monster / Effect / Fusion
-- Attribute: LIGHT
-- Race: Plant
-- Level 4
-- ATK 500 | DEF 1100
-- Setcode: 31
--
-- Effect Text:
-- 这张卡名在规则上也当作「新空间侠·光辉青苔」使用。这张卡用「新空间侠界限」的效果才能特殊召唤。这张卡进行战斗的场合，自己抽1张卡。这个效果抽到的卡给双方确认，这张卡得到那张卡的种类的以下效果。
-- ●怪兽卡：这个回合的战斗阶段结束。
-- ●魔法卡：这张卡可以直接攻击对方玩家。
-- ●陷阱卡：这张卡变成守备表示。
--[[ __CARD_HEADER_END__ ]]

--N・ティンクル・モス
function c13857930.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--Activate
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(13857930,0))
	e3:SetCategory(CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c13857930.condition)
	e3:SetTarget(c13857930.target)
	e3:SetOperation(c13857930.activate)
	c:RegisterEffect(e3)
	--add code
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e4:SetCode(EFFECT_ADD_CODE)
	e4:SetValue(17732278)
	c:RegisterEffect(e4)
end
function c13857930.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler()==Duel.GetAttacker() or e:GetHandler()==Duel.GetAttackTarget()
end
function c13857930.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(13857930)==0 end
	e:GetHandler():RegisterFlagEffect(13857930,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE,0,1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c13857930.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.Draw(tp,1,REASON_EFFECT)==0 then return end
	local tc=Duel.GetOperatedGroup():GetFirst()
	Duel.ConfirmCards(1-tp,tc)
	if tc:IsType(TYPE_MONSTER) then
		Duel.SkipPhase(Duel.GetTurnPlayer(),PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE_STEP,1)
	elseif tc:IsType(TYPE_SPELL) then
		if c==Duel.GetAttacker() and not c:IsHasEffect(EFFECT_CANNOT_DIRECT_ATTACK)
			and c:IsRelateToEffect(e) and c:IsFaceup() and Duel.SelectYesNo(tp,aux.Stringid(13857930,1)) then
			Duel.ChangeAttackTarget(nil)
		end
	else
		if c:IsRelateToEffect(e) and c:IsFaceup() then
			Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
		end
	end
	Duel.ShuffleHand(tp)
end
