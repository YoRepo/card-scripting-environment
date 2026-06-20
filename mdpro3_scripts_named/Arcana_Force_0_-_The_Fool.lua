--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 秘仪之力0-愚者  (ID: 62892347)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level 1
-- ATK 0 | DEF 0
-- Setcode: 5
--
-- Effect Text:
-- 这张卡不会被战斗破坏。这张卡不能变成守备表示。这张卡召唤·反转召唤·特殊召唤成功时，进行1次投掷硬币得到以下效果。
-- ●表：这张卡为对象的自己的魔法·陷阱·效果怪兽的效果无效并破坏。
-- ●里：这张卡为对象的对方的魔法·陷阱·效果怪兽的效果无效并破坏。
--[[ __CARD_HEADER_END__ ]]

--アルカナフォース0－THE FOOL
function c62892347.initial_effect(c)
	--battle indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	e2:SetCondition(c62892347.poscon)
	c:RegisterEffect(e2)
	--coin
	aux.EnableArcanaCoin(c,EVENT_SUMMON_SUCCESS,EVENT_FLIP_SUMMON_SUCCESS,EVENT_SPSUMMON_SUCCESS)
	--disable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_DISABLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_ONFIELD,LOCATION_ONFIELD)
	e3:SetCondition(aux.ArcanaCondition)
	e3:SetTarget(c62892347.distg)
	c:RegisterEffect(e3)
	--disable effect
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_CHAIN_SOLVING)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(aux.ArcanaCondition)
	e4:SetOperation(c62892347.disop)
	c:RegisterEffect(e4)
	--self destroy
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_SELF_DESTROY)
	e5:SetRange(LOCATION_MZONE)
	e5:SetTargetRange(LOCATION_ONFIELD,LOCATION_ONFIELD)
	e5:SetCondition(aux.ArcanaCondition)
	e5:SetTarget(c62892347.distg)
	c:RegisterEffect(e5)
end
function c62892347.poscon(e)
	return e:GetHandler():IsPosition(POS_FACEUP_ATTACK)
end
function c62892347.distg(e,c)
	local ec=e:GetHandler()
	if c==ec or c:GetCardTargetCount()==0 then return false end
	local val=ec:GetFlagEffectLabel(FLAG_ID_ARCANA_COIN)
	if val==1 then
		return c:GetControler()==ec:GetControler() and c:GetCardTarget():IsContains(ec)
	else
		return c:GetControler()~=ec:GetControler() and c:GetCardTarget():IsContains(ec)
	end
end
function c62892347.disop(e,tp,eg,ep,ev,re,r,rp)
	local ec=e:GetHandler()
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return end
	if not ec:IsRelateToEffect(re) then return end
	local val=ec:GetFlagEffectLabel(FLAG_ID_ARCANA_COIN)
	if (val==1 and rp==1-ec:GetControler()) or (val==0 and rp==ec:GetControler()) then return end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not g or not g:IsContains(ec) then return end
	if Duel.NegateEffect(ev,true) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(re:GetHandler(),REASON_EFFECT)
	end
end
