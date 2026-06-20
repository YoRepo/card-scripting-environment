--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 刚鬼 巨人食人魔  (ID: 78437364)
-- Type: Monster / Effect / Link
-- Attribute: EARTH
-- Race: Warrior
-- ATK 2600 | LINK
-- Setcode: 252
--
-- Effect Text:
-- 「刚鬼」怪兽2只以上
-- ①：只要这张卡在怪兽区域存在，场上的怪兽的攻击力下降那怪兽的原本守备力数值。
-- ②：这张卡被战斗·效果破坏的场合，可以作为代替把这张卡所连接区1只自己怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--剛鬼ザ・グレート・オーガ
function c78437364.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkSetCard,0xfc),2)
	c:EnableReviveLimit()
	--atkdown
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetValue(c78437364.atkval)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c78437364.desreptg)
	e2:SetOperation(c78437364.desrepop)
	c:RegisterEffect(e2)
end
function c78437364.atkval(e,c)
	local val=math.max(c:GetBaseDefense(),0)
	return val*-1
end
function c78437364.repfilter(c,e,tp)
	return c:IsControler(tp) and c:IsLocation(LOCATION_MZONE)
		and c:IsDestructable(e) and not c:IsStatus(STATUS_DESTROY_CONFIRMED)
end
function c78437364.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then
		local g=c:GetLinkedGroup()
		return c:IsReason(REASON_EFFECT+REASON_BATTLE) and not c:IsReason(REASON_REPLACE) and g:IsExists(c78437364.repfilter,1,nil,e,tp)
	end
	if Duel.SelectEffectYesNo(tp,c,96) then
		local g=c:GetLinkedGroup()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESREPLACE)
		local sg=g:FilterSelect(tp,c78437364.repfilter,1,1,nil,e,tp)
		e:SetLabelObject(sg:GetFirst())
		sg:GetFirst():SetStatus(STATUS_DESTROY_CONFIRMED,true)
		return true
	else return false end
end
function c78437364.desrepop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	tc:SetStatus(STATUS_DESTROY_CONFIRMED,false)
	Duel.Destroy(tc,REASON_EFFECT+REASON_REPLACE)
end
