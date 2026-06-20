--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: “艾”眼之影  (ID: 77421977)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
-- Setcode: 310
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。以自己场上1只「@火灵天星」怪兽为对象才能把这张卡发动。
-- ①：只要这张卡在魔法与陷阱区域存在，作为对象的怪兽的攻击力上升800，可以攻击的对方怪兽必须向作为对象的怪兽作出攻击。
-- ②：魔法与陷阱区域的表侧表示的这张卡因对方的效果从场上离开，被送去墓地的场合或者被除外的场合发动。自己从卡组抽1张。
--[[ __CARD_HEADER_END__ ]]

--Aiシャドー
function c77421977.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CONTINUOUS_TARGET)
	e1:SetCondition(aux.dscon)
	e1:SetTarget(c77421977.target)
	e1:SetOperation(c77421977.activate)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_TARGET)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetValue(800)
	c:RegisterEffect(e2)
	--must attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_MUST_ATTACK)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetCondition(c77421977.effcon)
	c:RegisterEffect(e3)
	--must attack monster
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_MUST_ATTACK_MONSTER)
	e4:SetRange(LOCATION_SZONE)
	e4:SetTargetRange(0,LOCATION_MZONE)
	e4:SetCondition(c77421977.effcon)
	e4:SetValue(c77421977.atklimit)
	c:RegisterEffect(e4)
	--draw
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_DRAW)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e5:SetCode(EVENT_TO_GRAVE)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e5:SetCountLimit(1,77421977)
	e5:SetCondition(c77421977.drcon)
	e5:SetTarget(c77421977.drtg)
	e5:SetOperation(c77421977.drop)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetCode(EVENT_REMOVE)
	c:RegisterEffect(e6)
end
function c77421977.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x135)
end
function c77421977.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c77421977.cfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c77421977.cfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c77421977.cfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c77421977.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) then
		c:SetCardTarget(tc)
	end
end
function c77421977.effcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFirstCardTarget()~=nil
end
function c77421977.atklimit(e,c)
	return e:GetHandler():IsHasCardTarget(c)
end
function c77421977.drcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousPosition(POS_FACEUP) and c:IsPreviousLocation(LOCATION_SZONE) and c:IsPreviousControler(tp)
		and c:IsReason(REASON_EFFECT) and rp==1-tp
end
function c77421977.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c77421977.drop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
