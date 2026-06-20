--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 融合复制  (ID: 43331750)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 70
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：以自己或对方的墓地1张「融合」通常·速攻魔法卡为对象才能发动。那张魔法卡除外。那之后，那张魔法卡发动时的效果适用。
--[[ __CARD_HEADER_END__ ]]

--融合複製
local s,id,o=GetID()
function s.initial_effect(c)
	--copy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.filter(c)
	return (c:GetType()==TYPE_SPELL or c:IsType(TYPE_QUICKPLAY)) and c:IsSetCard(0x46) and c:IsAbleToRemove()
		and c:CheckActivateEffect(true,true,false)~=nil
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and s.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(s.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,s.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil)
	local tc=g:GetFirst()
	Duel.ClearTargetCard()
	tc:CreateEffectRelation(e)
	e:SetLabelObject(tc)
	local te,ceg,cep,cev,cre,cr,crp=g:GetFirst():CheckActivateEffect(true,true,true)
	e:SetProperty(te:GetProperty())
	local tg=te:GetTarget()
	if tg then tg(e,tp,ceg,cep,cev,cre,cr,crp,1) end
	Duel.ClearOperationInfo(0)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local fc=e:GetLabelObject()
	if fc and fc:IsRelateToChain() and Duel.Remove(fc,POS_FACEUP,REASON_EFFECT)>0
		and fc:IsLocation(LOCATION_REMOVED) then
		local fe=fc:CheckActivateEffect(true,true,true)
		if fe then
			local op=fe:GetOperation()
			if op then
				Duel.BreakEffect()
				op(e,tp,eg,ep,ev,re,r,rp)
			end
		end
	end
end
