--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 机械龙 动力工具  (ID: 68084557)
-- Type: Monster / Effect / Synchro
-- Attribute: DARK
-- Race: Machine
-- Level 7
-- ATK 2300 | DEF 2500
-- Setcode: 194
--
-- Effect Text:
-- 调整＋调整以外的怪兽1只以上
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：自己回合，这张卡有装备魔法卡被装备时才能发动。自己从卡组抽1张。
-- ②：1回合1次，以给其他怪兽装备的1张表侧表示的装备卡为对象才能发动。那张卡给这张卡装备。这个效果在对方回合也能发动。
--[[ __CARD_HEADER_END__ ]]

--機械竜 パワー・ツール
function c68084557.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--draw
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetDescription(aux.Stringid(68084557,0))
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_EQUIP)
	e1:SetCountLimit(1,68084557)
	e1:SetCondition(c68084557.drcon)
	e1:SetTarget(c68084557.drtg)
	e1:SetOperation(c68084557.drop)
	c:RegisterEffect(e1)
	--equip change
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(68084557,1))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetTarget(c68084557.eqtg)
	e2:SetOperation(c68084557.eqop)
	c:RegisterEffect(e2)
end
function c68084557.drcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c68084557.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c68084557.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c68084557.eqfilter(c,ec)
	return c:IsType(TYPE_EQUIP) and c:GetEquipTarget() and c:GetEquipTarget()~=ec and c:CheckEquipTarget(ec)
end
function c68084557.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and c68084557.eqfilter(chkc,e:GetHandler()) end
	if chk==0 then return Duel.IsExistingTarget(c68084557.eqfilter,tp,LOCATION_SZONE,LOCATION_SZONE,1,nil,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c68084557.eqfilter,tp,LOCATION_SZONE,LOCATION_SZONE,1,1,nil,e:GetHandler())
end
function c68084557.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:CheckEquipTarget(c) then
		Duel.Equip(tp,tc,c)
	end
end
