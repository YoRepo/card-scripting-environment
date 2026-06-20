--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 光之金字塔  (ID: 53569894)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上表侧表示存在的这张卡从场上离开的场合，自己场上存在的「斯芬克斯·安德鲁」和「斯芬克斯·迪蕾雅」破坏并从游戏中除外。
--[[ __CARD_HEADER_END__ ]]

--光のピラミッド
function c53569894.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_LEAVE_FIELD_P)
	e2:SetOperation(c53569894.checkop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY+CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetLabelObject(e2)
	e3:SetOperation(c53569894.leave)
	c:RegisterEffect(e3)
end
function c53569894.filter(c)
	return c:IsFaceup() and c:IsCode(15013468,51402177)
end
function c53569894.checkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsDisabled() or not c:IsStatus(STATUS_EFFECT_ENABLED) then
		e:SetLabel(1)
	else e:SetLabel(0) end
end
function c53569894.leave(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if e:GetLabelObject():GetLabel()==0 and c:IsPreviousControler(tp) then
		local g=Duel.GetMatchingGroup(c53569894.filter,tp,LOCATION_ONFIELD,0,nil)
		Duel.Destroy(g,REASON_EFFECT,LOCATION_REMOVED)
	end
end
