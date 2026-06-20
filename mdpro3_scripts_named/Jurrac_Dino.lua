--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 朱罗纪恐兽  (ID: 17948378)
-- Type: Monster / Effect / Tuner
-- Attribute: FIRE
-- Race: Dinosaur
-- Level 3
-- ATK 1700 | DEF 800
-- Setcode: 34
--
-- Effect Text:
-- ①：这张卡战斗破坏对方怪兽的回合的结束阶段，把自己场上1只「朱罗纪」怪兽解放才能发动。自己抽2张。
--[[ __CARD_HEADER_END__ ]]

--ジュラック・デイノ
function c17948378.initial_effect(c)
	--reg
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(aux.bdocon)
	e1:SetOperation(c17948378.regop)
	c:RegisterEffect(e1)
	--draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(17948378,0))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_FIELD)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c17948378.drcon)
	e2:SetCost(c17948378.drcost)
	e2:SetTarget(c17948378.drtg)
	e2:SetOperation(c17948378.drop)
	c:RegisterEffect(e2)
end
function c17948378.regop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(17948378,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
end
function c17948378.drcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(17948378)~=0
end
function c17948378.drcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsSetCard,1,nil,0x22) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsSetCard,1,1,nil,0x22)
	Duel.Release(g,REASON_COST)
end
function c17948378.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c17948378.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
