--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 光之结界  (ID: 73206827)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：自己准备阶段发动。进行1次投掷硬币，里出现的场合，这张卡的②③的效果直到下次的自己准备阶段无效。
-- ②：自己的「秘仪之力」怪兽的召唤·反转召唤·特殊召唤时发动的效果不进行投掷硬币而选里表的其中1个适用。
-- ③：自己的「秘仪之力」怪兽战斗破坏对方怪兽的场合发动。自己基本分回复那只破坏的怪兽的原本攻击力的数值。
--[[ __CARD_HEADER_END__ ]]

--光の結界
function c73206827.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--coin
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(73206827,0))
	e2:SetCategory(CATEGORY_COIN)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCountLimit(1)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetCondition(c73206827.coincon)
	e2:SetTarget(c73206827.cointg)
	e2:SetOperation(c73206827.coinop)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(73206827)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetRange(LOCATION_FZONE)
	e3:SetTargetRange(1,0)
	e3:SetCondition(c73206827.effectcon)
	c:RegisterEffect(e3)
	--
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(73206827,1))
	e4:SetCategory(CATEGORY_RECOVER)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCode(EVENT_BATTLE_DESTROYING)
	e4:SetCondition(c73206827.reccon)
	e4:SetTarget(c73206827.rectg)
	e4:SetOperation(c73206827.recop)
	c:RegisterEffect(e4)
end
function c73206827.coincon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c73206827.cointg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
end
function c73206827.coinop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local res=Duel.TossCoin(tp,1)
	if res==0 then
		c:RegisterFlagEffect(73206828,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN,0,2)
	end
end
function c73206827.effectcon(e)
	local c=e:GetHandler()
	return c:GetFlagEffect(73206828)==0 or c:IsHasEffect(EFFECT_CANNOT_DISABLE)
end
function c73206827.reccon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rc=eg:GetFirst()
	return c73206827.effectcon(e) and rc:IsRelateToBattle() and rc:IsSetCard(0x5) and rc:IsFaceup() and rc:IsControler(tp)
end
function c73206827.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local tc=eg:GetFirst():GetBattleTarget()
	local atk=tc:GetBaseAttack()
	if atk<0 then atk=0 end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(atk)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,atk)
end
function c73206827.recop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	if d>0 then
		Duel.Recover(p,d,REASON_EFFECT)
	end
end
