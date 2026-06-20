--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 时间潜行者停秒  (ID: 81670445)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 294
--
-- Effect Text:
-- 这个卡名的②的效果1回合只能使用1次。
-- ①：只要这张卡在魔法与陷阱区域存在，自己场上的超量怪兽在特殊召唤的回合不会成为对方的效果的对象，不会被对方的效果破坏。
-- ②：以自己场上1只超量怪兽为对象才能发动。那只怪兽的攻击力直到回合结束时上升那些超量素材数量×300。并且那只怪兽有原本持有者是对方的卡在作为超量素材的场合，更在这个回合让那只怪兽可以直接攻击。
--[[ __CARD_HEADER_END__ ]]

--クロノダイバー・ハック
function c81670445.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c81670445.xyztarget)
	e2:SetValue(c81670445.indesval)
	c:RegisterEffect(e2)
	--cannot be target
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(c81670445.xyztarget)
	e3:SetValue(aux.tgoval)
	c:RegisterEffect(e3)
	--atkup
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(81670445,0))
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_SZONE)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetCountLimit(1,81670445)
	e4:SetTarget(c81670445.atktg)
	e4:SetOperation(c81670445.atkop)
	c:RegisterEffect(e4)
end
function c81670445.indesval(e,re,rp)
	return rp~=e:GetHandlerPlayer()
end
function c81670445.xyztarget(e,c)
	return c:IsType(TYPE_XYZ) and c:IsStatus(STATUS_SPSUMMON_TURN)
end
function c81670445.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:GetOverlayCount()>0
end
function c81670445.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c81670445.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c81670445.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c81670445.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c81670445.matfil(c,e)
	return c:GetOwner()~=e:GetHandlerPlayer()
end
function c81670445.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(tc:GetOverlayCount()*300)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		if tc:GetOverlayGroup():IsExists(c81670445.matfil,1,nil,e) then
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_DIRECT_ATTACK)
			e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e2)
		end
	end
end
