--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 刚鬼 雷霆食人魔  (ID: 30010480)
-- Type: Monster / Effect / Link
-- Attribute: EARTH
-- Race: Warrior
-- ATK 2200 | LINK
-- Setcode: 252
--
-- Effect Text:
-- 「刚鬼」怪兽2只以上
-- ①：只要这张卡在怪兽区域存在，回合玩家让以下效果适用。
-- ●自己主要阶段在通常召唤外加上只有1次，可以从手卡把1只怪兽往作为这张卡所连接区的自己场上召唤。
-- ②：这张卡所连接区的怪兽被战斗·效果破坏的场合才能发动。这张卡的攻击力上升400。
--[[ __CARD_HEADER_END__ ]]

--剛鬼サンダー・オーガ
function c30010480.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkSetCard,0xfc),2)
	c:EnableReviveLimit()
	--extra summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(30010480,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_EXTRA_SUMMON_COUNT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_HAND,LOCATION_HAND)
	e1:SetValue(c30010480.sumval)
	c:RegisterEffect(e1)
	--atk
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(30010480,1))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c30010480.atkcon)
	e3:SetOperation(c30010480.atkop)
	c:RegisterEffect(e3)
end
function c30010480.sumval(e,c)
	if c:IsControler(e:GetHandlerPlayer()) then
		local sumzone=e:GetHandler():GetLinkedZone()
		local relzone=-bit.lshift(1,e:GetHandler():GetSequence())
		return 0,sumzone,relzone
	else
		local sumzone=e:GetHandler():GetLinkedZone(1-e:GetHandlerPlayer())
		local relzone=-bit.lshift(1,e:GetHandler():GetSequence()+16)
		return 0,sumzone,relzone
	end
end
function c30010480.cfilter(c,tp,zone)
	local seq=c:GetPreviousSequence()
	if c:IsPreviousControler(1-tp) then seq=seq+16 end
	return c:IsReason(REASON_BATTLE+REASON_EFFECT)
		and c:IsPreviousLocation(LOCATION_MZONE) and bit.extract(zone,seq)~=0
end
function c30010480.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c30010480.cfilter,1,nil,tp,e:GetHandler():GetLinkedZone())
end
function c30010480.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(400)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
	end
end
