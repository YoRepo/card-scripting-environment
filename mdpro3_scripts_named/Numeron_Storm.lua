--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 源数风暴  (ID: 20936251)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 330
--
-- Effect Text:
-- ①：自己场上有「原数天灵」怪兽存在的场合才能发动。对方场上的魔法·陷阱卡全部破坏，给与对方1000伤害。
--[[ __CARD_HEADER_END__ ]]

--ヌメロン・ストーム
function c20936251.initial_effect(c)
	--Destroy
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c20936251.descon)
	e1:SetTarget(c20936251.destg)
	e1:SetOperation(c20936251.desop)
	c:RegisterEffect(e1)
end
function c20936251.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x169)
end
function c20936251.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c20936251.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c20936251.desfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c20936251.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c20936251.desfilter,tp,0,LOCATION_ONFIELD,1,c) end
	local sg=Duel.GetMatchingGroup(c20936251.desfilter,tp,0,LOCATION_ONFIELD,c)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1000)
end
function c20936251.desop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c20936251.desfilter,tp,0,LOCATION_ONFIELD,aux.ExceptThisCard(e))
	if Duel.Destroy(sg,REASON_EFFECT)>0 then
		Duel.Damage(1-tp,1000,REASON_EFFECT)
	end
end
