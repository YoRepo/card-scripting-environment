--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 源数网络  (ID: 41418852)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
-- Setcode: 330
--
-- Effect Text:
-- 这个卡名的①的效果1回合只能使用1次。
-- ①：自己主要阶段，把满足发动条件的1张「源数」通常魔法卡从卡组送去墓地才能发动。这个效果变成和那张魔法卡发动时的效果相同。
-- ②：只要这张卡在场地区域存在，自己场上的「源数」超量怪兽把超量素材取除来让效果发动的场合，也能不把超量素材取除来发动。
--[[ __CARD_HEADER_END__ ]]

--ヌメロン・ネットワーク
function c41418852.initial_effect(c)
	--activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--copy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(41418852,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_FZONE)
	e1:SetCountLimit(1,41418852)
	e1:SetCost(c41418852.cpcost)
	e1:SetTarget(c41418852.cptg)
	e1:SetOperation(c41418852.cpop)
	c:RegisterEffect(e1)
	--remove overlay replace
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(41418852,1))
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_OVERLAY_REMOVE_REPLACE)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCondition(c41418852.rcon)
	e2:SetOperation(c41418852.rop)
	c:RegisterEffect(e2)
end
function c41418852.cpfilter(c)
	return c:GetType()==TYPE_SPELL and c:IsSetCard(0x14a) and c:IsAbleToGraveAsCost()
		and c:CheckActivateEffect(false,true,false)~=nil
end
function c41418852.cpcost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return true end
end
function c41418852.cptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()==0 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c41418852.cpfilter,tp,LOCATION_DECK,0,1,nil)
	end
	e:SetLabel(0)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c41418852.cpfilter,tp,LOCATION_DECK,0,1,1,nil)
	local te,ceg,cep,cev,cre,cr,crp=g:GetFirst():CheckActivateEffect(false,true,true)
	Duel.SendtoGrave(g,REASON_COST)
	e:SetProperty(te:GetProperty())
	local tg=te:GetTarget()
	if tg then tg(e,tp,ceg,cep,cev,cre,cr,crp,1) end
	te:SetLabelObject(e:GetLabelObject())
	e:SetLabelObject(te)
	Duel.ClearOperationInfo(0)
end
function c41418852.cpop(e,tp,eg,ep,ev,re,r,rp)
	local te=e:GetLabelObject()
	if te then
		e:SetLabelObject(te:GetLabelObject())
		local op=te:GetOperation()
		if op then op(e,tp,eg,ep,ev,re,r,rp) end
	end
end
function c41418852.rcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_COST)~=0 and re:IsActivated() and re:IsActiveType(TYPE_XYZ) and re:GetHandler():IsSetCard(0x14a)
		and ep==e:GetOwnerPlayer() and re:GetActivateLocation()&LOCATION_MZONE~=0
end
function c41418852.rop(e,tp,eg,ep,ev,re,r,rp)
	return ev
end
